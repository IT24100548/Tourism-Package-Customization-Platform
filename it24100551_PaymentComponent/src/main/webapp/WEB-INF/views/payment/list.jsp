<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            color: #495057;
        }
        .payment-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            padding: 2rem;
            margin-top: 2rem;
            margin-bottom: 2rem;
        }
        .page-header {
            border-bottom: 2px solid #e9ecef;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
        }
        .search-box {
            position: relative;
            margin-bottom: 2rem;
        }
        .search-box i {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }
        .search-input {
            padding-left: 2.5rem;
            border-radius: 10px;
            border: 2px solid #e9ecef;
            transition: all 0.3s;
        }
        .search-input:focus {
            border-color: #80bdff;
            box-shadow: 0 0 0 0.2rem rgba(0,123,255,.25);
        }
        .btn {
            border-radius: 8px;
            padding: 0.5rem 1rem;
            font-weight: 500;
            transition: all 0.3s;
        }
        .btn-primary {
            background: #0d6efd;
            border: none;
        }
        .btn-primary:hover {
            background: #0b5ed7;
            transform: translateY(-1px);
        }
        .table {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 0 15px rgba(0,0,0,0.05);
        }
        .table thead {
            background-color: #f8f9fa;
        }
        .table th {
            border-top: none;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            color: #495057;
        }
        .table td {
            vertical-align: middle;
        }
        .badge {
            padding: 0.5rem 0.8rem;
            font-weight: 500;
            border-radius: 6px;
        }
        .badge.bg-success {
            background-color: #198754 !important;
        }
        .badge.bg-warning {
            background-color: #ffc107 !important;
            color: #000;
        }
        .badge.bg-danger {
            background-color: #dc3545 !important;
        }
        .btn-group .btn {
            padding: 0.4rem 0.6rem;
            margin: 0 0.1rem;
            border-radius: 6px;
        }
        .btn-info {
            background-color: #0dcaf0;
            border: none;
            color: white;
        }
        .btn-info:hover {
            background-color: #0bacce;
            color: white;
        }
        .btn-success {
            background-color: #198754;
            border: none;
        }
        .btn-success:hover {
            background-color: #157347;
        }
        .btn-danger {
            background-color: #dc3545;
            border: none;
        }
        .btn-danger:hover {
            background-color: #bb2d3b;
        }
        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #6c757d;
        }
        .amount-column {
            font-weight: 600;
            color: #198754;
        }
        .payment-number {
            font-family: monospace;
            color: #0d6efd;
            font-weight: 500;
        }
        .table-hover tbody tr:hover {
            background-color: #f8f9fa;
            transition: background-color 0.3s;
        }
        .action-buttons {
            white-space: nowrap;
        }
    </style>
</head>
</html>
