﻿namespace PiggyBank.Data.Models;

public partial class Account
{
    public enum BudgetType
    {
        Asset,
        Equity,
        Expense,
        Income,
        Liability,
    }
}

