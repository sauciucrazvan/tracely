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
const checkboxes = "Checklist Board";

// Widgets
const about = "About";
const stats = "Statistics";

// Stats content
const notesSaved = "Notes saved:";
const todoSaved = "Checklists saved:";

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

const colors = [
  'red',
  'cyan',
  'lightblue',
  'blue',
  'green',
  'lightgreen',
  'lime',
  'yellow',
  'amber',
  'orange',
  'pink',
  'purple',
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

const noteWithoutName = "Please name your note.";
const noteWithoutContent = "Please add content to your note.";

const checklistWithoutName = "The checklist does not have a name!";
const checkboxWithoutName = "The checkbox is not named! :(";

/*

  PROMPTS

*/

const removeNote =
    "Are you sure you want to delete this note?\nThis action can not be reverted!";
const removeChecklist =
    "Are you sure you want to delete this checklist?\nEvery entry will be deleted and this action can not be reverted!";
const removeCheckbox = "Are you sure you want to delete this checkbox?";
