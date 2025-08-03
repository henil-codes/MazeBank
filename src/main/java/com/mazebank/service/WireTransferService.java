package com.mazebank.service;

import com.mazebank.dto.WireTransferDTO;
import com.mazebank.exception.InvalidTransferException;
import com.mazebank.exception.ResourceNotFoundException;

import java.sql.SQLException;

public interface WireTransferService {
    void processWireTransfer(WireTransferDTO transferDto) throws SQLException, InvalidTransferException, ResourceNotFoundException;
}