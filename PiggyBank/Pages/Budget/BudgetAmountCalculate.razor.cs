namespace PiggyBank.Pages.Budget;

public partial class BudgetAmountCalculate
{
    [Parameter]
    public Guid budgetId { get; set; }

    private bool _found = true;
    private string _notFoundMessage = "Budget not found";
    private Data.Models.Budget? _budget;
    private FormModel _model = new();
    private EditContext? _editContext;
    private ValidationMessageStore? _validationMessageStore;
    private bool _addingAmounts = false;
    protected override async Task OnParametersSetAsync()
    {
        var today = DateOnly.FromDateTime(DateTime.Today);
        _model.StartDate = new DateOnly(today.Year - 1, 1, 1);
        _model.EndDate = new DateOnly(today.Year, 12, 31);
        _budget = await BudgetService.GetBudgetAsync(budgetId);
        if (_budget is null)
        {
            _notFoundMessage = $"Budget ID '{budgetId}' not found";
            _found = false;
            return;
        }

        _editContext = new EditContext(_model);
        _validationMessageStore = new ValidationMessageStore(_editContext);
        _editContext!.OnValidationRequested += HandleValidationRequested;
    }

    private void HandleValidationRequested(object? sender, ValidationRequestedEventArgs args)
    {
        if (_budget is null)
        {
            return;
        }

        if (_validationMessageStore is null)
        {
            return;
        }

        _validationMessageStore.Clear();
        if (_model.StartDate.Day != 1)
        {
            _validationMessageStore.Add(() => _model.StartDate, "Start date must be the first day of the month");
        }

        var endMonthDays = DateTime.DaysInMonth(_model.EndDate.Year, _model.EndDate.Month);
        if (_model.EndDate.Day != endMonthDays)
        {
            _validationMessageStore.Add(() => _model.EndDate, "End date must be on the last day of the month");
        }
    }

    private async Task SaveBudget()
    {
        if (_budget is null || _budget is null || _addingAmounts)
        {
            return;
        }

        _addingAmounts = true;
        var config = GetAmountConfig();
        await BudgetService.CalculateAmounts(_budget, config);
        await BudgetService.Save(_budget);
        _addingAmounts = false;
        Cancel();
    }

    private void Cancel()
    {
        if (_budget is null)
        {
            return;
        }

        NavigationManager.NavigateTo(PageRoute.BudgetEditFor(_budget.Id));
    }

    private BudgetAmount.Configuration GetAmountConfig()
    {
        var config = new BudgetAmount.Configuration
        {
            DefaultPeriod = _model.DefaultPeriod,
            StartDate = _model.StartDate,
            EndDate = _model.EndDate
        };
        if (_model.IncludeAsset)
        {
            config.AccountTypes.Add(Data.Models.Account.AccountType.Asset);
        }

        if (_model.IncludeExpense)
        {
            config.AccountTypes.Add(Data.Models.Account.AccountType.Expense);
        }

        if (_model.IncludeIncome)
        {
            config.AccountTypes.Add(Data.Models.Account.AccountType.Income);
        }

        if (_model.IncludeLiability)
        {
            config.AccountTypes.Add(Data.Models.Account.AccountType.Liability);
        }

        return config;
    }

    private class FormModel
    {
        public DateHelper.PeriodType DefaultPeriod { get; set; } = DateHelper.PeriodType.Monthly;
        public DateOnly StartDate { get; set; } = DateOnly.MinValue;
        public DateOnly EndDate { get; set; } = DateOnly.MaxValue;
        public bool IncludeAsset { get; set; } = false;
        public bool IncludeExpense { get; set; } = true;
        public bool IncludeIncome { get; set; } = true;
        public bool IncludeLiability { get; set; } = false;

        [Required]
        [Range(typeof(bool), "true", "true", ErrorMessage = "At least one account type is required.")]
        public bool AccountSelected => IncludeAsset || IncludeExpense || IncludeIncome || IncludeLiability;
    }
}
