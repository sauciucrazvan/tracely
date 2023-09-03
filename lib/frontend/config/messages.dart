/*

  APPLICATION

*/

const appName = "Tracely";
const appDesc =
    "is a fully fledged management app with cloud synchronization. Keep track of your projects, ideas, notes - and everything you can think of.";

const loading = "Please wait while we do our magic";

/*

  LOGIN PAGE

*/

// Authentification
const login = "Log in or sign up in seconds!";
const logout = "Are you sure you want to logout?";

// Services
const services = "Use one of the services below to continue using $appName.";
const google = "Continue with Google";

const usedData =
    "By continuing, you agree to $appName's Terms of Services & Privacy Policy";

/*

  DASHBOARD PAGE

*/

// Pages & Titles
const dashboard = "Home";
const notes = "Notes";
const todo = "Agenda";
const expenses = "Expenses";
const checkboxes = "Checklist Board";

// Widgets
const about = "About";
const stats = "Statistics";
const tips = "Tips & Secrets";

// Stats content
const notesSaved = "Notes synced:";
const todoSaved = "Checklists synced:";
const expensesSaved = "Expenses synced:";

// Tips content
const tipsList = {
  "• Long press the checkbox to mark it as complete.",
  "• Every now and then some checklists might have a special icon.",
  "• If you use markdown, consider leaving a space between every message.",
  "• Expenses older than 60 days are automatically removed.",
};

// Routes
const addEntries = "Add";

const addTodo = "Add a new checklist!";

// Daily message that's being displayed on the home page
const welcome = {
  "Welcome back,",
  "Glad to see you,",
  "We love you,",
  "Greetings,",
  "We are here for you,",
  "Everything for you,",
};

/*

  NOTES PAGES

*/

const addNote = "Let's add a new note!";

const chooseNoteTitle = "We should start by naming your note:";
const enterNoteContent =
    "Fill in your note content down below.\nYou can use the markup language called Markdown.";
const shouldUseMarkdown = "Should we use Markdown formatting?";

const modifyNote = "You're editing a note!";
const editNoteTitle = "Edit your title:";
const editNoteContent = "Edit the content of your note:";

const lastEdit = "Last edit";

/*

  CHECKLISTS & CHECKBOXES

*/

const checkboxesCountSingular = "entry";
const checkboxesCountPlural = "entries";

const rename = "Rename checklist";

const addCheckbox = "Adding a new checkbox";
const chooseTitleCheckbox = "Let's choose a title for your checkbox";
const selectCheckboxDate = "Select a date";

const editCheckbox = "Editing a checkbox";
const editTitleCheckbox = "Edit the title:";

/*

  EXPENSES

*/

const expensesChartTitle = "Summary";

const addExpense = "Adding an expense!";
const chooseTitleExpense = "What product did you buy?";
const chooseValueExpense = "How much did you pay?";
const selectExpenseDate = "When did it happend?";

const modifyExpense = "You're editing a note!";

List<String> currencies = [
  "EUR",
  "USD",
  "JPY",
  "GBP",
  "AUD",
  "CAD",
  "CHF",
  "CNY",
  "SEK",
  "NZD",
  "KRW",
  "SGD",
  "HKD",
  "NOK",
  "MXN",
  "INR",
  "BRL",
  "ZAR",
  "RON",
  "RUB",
  "TRY",
];

/*

  ERRORS

*/

const noConnection = "No internet connection available!";
const reconnectNeeded =
    "Please reconnect to the internet in order to use $appName!";
const restartNeeded = "Please restart or refresh the app in order to use it.";

const noNotesSaved = "You don't have any notes stored yet! :(";
const noChecklistsSaved = "No checklists saved.";
const noCheckboxesSaved = "No checkboxes here!";
const noExpensesSaved = "No expenses saved!";

const noteWithoutName = "Please name your note.";
const noteWithoutContent = "Please add content to your note.";

const checklistWithoutName = "The checklist does not have a name!";
const checkboxWithoutName = "The checkbox is not named! :(";

const expenseWithoutName = "Please name your expense.";
const expenseWithoutValue = "Please enter the value of the product.";

/*

  PROMPTS

*/

const removeNote =
    "Are you sure you want to delete this note?\nThis action can not be reverted!";
const removeChecklist =
    "Are you sure you want to delete this checklist?\nEvery entry will be deleted and this action can not be reverted!";
const removeCheckbox = "Are you sure you want to delete this checkbox?";
const removeExpense =
    "Are you sure you want to remove this expense?\nThis action cannot be undone!";
