package com.mazebank.service;

import com.mazebank.dao.AccountDao;
import com.mazebank.dao.AccountDaoImpl;
import com.mazebank.dao.WireTransferDao;
import com.mazebank.dao.WireTransferDaoImpl;
import com.mazebank.dto.WireTransferDTO;
import com.mazebank.exception.InvalidTransferException;
import com.mazebank.exception.ResourceNotFoundException;
import com.mazebank.model.Account;
import com.mazebank.model.AccountStatus;
import com.mazebank.model.WireTransfer;
import com.mazebank.util.DBConnection;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;

public class WireTransferServiceImpl implements WireTransferService {

	private final AccountDao accountDao;
	private final WireTransferDao wireTransferDao;

	public WireTransferServiceImpl() {
		this.accountDao = new AccountDaoImpl();
		this.wireTransferDao = new WireTransferDaoImpl();
	}

	@Override
	public void processWireTransfer(WireTransferDTO transferDto)
			throws SQLException, InvalidTransferException, ResourceNotFoundException {
		Connection conn = null;
		try {
			conn = DBConnection.getConnection();
			conn.setAutoCommit(false); // Start transaction

			// 1. Validate the sender's account
			Account senderAccount = accountDao.findByAccountNumber(transferDto.getSenderAccountNumber(), conn)
					.orElseThrow(() -> new ResourceNotFoundException("Sender account not found."));

			if (senderAccount.getUserId() != transferDto.getUserId()) {
				throw new InvalidTransferException("Sender account does not belong to the logged-in user.");
			}

			// 2. Validate the recipient's account
			Account recipientAccount = accountDao.findByAccountNumber(transferDto.getRecipientAccountNumber(), conn)
					.orElseThrow(() -> new ResourceNotFoundException("Recipient account not found."));

			// New validation: Check if recipient's account is active
			if (recipientAccount.getStatus() != AccountStatus.ACTIVE) {
				throw new InvalidTransferException("Recipient's account is not active.");
			}

			// 3. Validate transfer amount and balance
			if (transferDto.getAmount().compareTo(BigDecimal.ZERO) <= 0) {
				throw new InvalidTransferException("Transfer amount must be positive.");
			}

			BigDecimal newSenderBalance = senderAccount.getBalance().subtract(transferDto.getAmount());
			if (newSenderBalance.compareTo(senderAccount.getOverdraftLimit().negate()) < 0) {
				throw new InvalidTransferException("Insufficient funds. Transfer amount exceeds overdraft limit.");
			}

			// 4. Update balances
			accountDao.updateAccountBalance(senderAccount.getAccountId(), newSenderBalance, conn);
			BigDecimal newRecipientBalance = recipientAccount.getBalance().add(transferDto.getAmount());
			accountDao.updateAccountBalance(recipientAccount.getAccountId(), newRecipientBalance, conn);

			// 5. Log the transfer record
			WireTransfer transfer = new WireTransfer();
			transfer.setSenderAccountId(senderAccount.getAccountId());
			transfer.setRecipientAccountId(recipientAccount.getAccountId());
			transfer.setSenderAccountNumber(senderAccount.getAccountNumber());
			transfer.setRecipientAccountNumber(recipientAccount.getAccountNumber());
			transfer.setAmount(transferDto.getAmount());
			transfer.setDescription(transferDto.getDescription());
			transfer.setStatus("COMPLETED");
			wireTransferDao.save(conn, transfer);

			// 6. Commit the transaction
			conn.commit();

		} catch (SQLException e) {
			if (conn != null) {
				try {
					conn.rollback();
				} catch (SQLException rbEx) {
					rbEx.printStackTrace();
				}
			}
			throw e;
		} finally {
			if (conn != null) {
				try {
					conn.setAutoCommit(true);
					conn.close();
				} catch (SQLException closeEx) {
					closeEx.printStackTrace();
				}
			}
		}
	}
}