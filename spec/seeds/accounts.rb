def seed_accounts
  usd_id = PiggyBank::Commodity.find(name: "USD").commodity_id

  PiggyBank::Account.create parent_id: nil,
                            commodity_id: usd_id,
                            name: "Assets",
                            is_placeholder: true,
                            type: PiggyBank::Account::TYPE_CODE[:asset],
                            type_data: ""

  PiggyBank::Account.create parent_id: nil,
                            commodity_id: usd_id,
                            name: "Liabilities",
                            is_placeholder: true,
                            type: PiggyBank::Account::TYPE_CODE[:liability],
                            type_data: ""

  PiggyBank::Account.create parent_id: nil,
                            commodity_id: usd_id,
                            name: "Equity",
                            is_placeholder: true,
                            type: PiggyBank::Account::TYPE_CODE[:equity],
                            type_data: ""

  PiggyBank::Account.create parent_id: nil,
                            commodity_id: usd_id,
                            name: "Income",
                            is_placeholder: true,
                            type: PiggyBank::Account::TYPE_CODE[:income],
                            type_data: ""

  PiggyBank::Account.create parent_id: nil,
                            commodity_id: usd_id,
                            name: "Expense",
                            is_placeholder: true,
                            type: PiggyBank::Account::TYPE_CODE[:expense],
                            type_data: ""

  liabilities = PiggyBank::Account.find(name: "Liabilities")
  PiggyBank::Account.create parent_id: liabilities.account_id,
                            commodity_id: usd_id,
                            name: "Mortgage",
                            is_placeholder: false,
                            type: PiggyBank::Account::TYPE_CODE[:mortgage],
                            type_data: ""
end
