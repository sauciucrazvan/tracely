/*

  APPLICATION

*/

const appName = "Tracely";
const appDesc =
    "is a fully fledged management app with cloud synchronization. Keep track of your projects, ideas, notes - and everything you can think of.";

const noConnection = "No internet connection available!";
const reconnectNeeded =
    "Please reconnect to the internet in order to use $appName!";
const restartNeeded = "Please restart or refresh the app in order to use it.";

/*

  LOGIN PAGE

*/

const login = "Log in or sign up in seconds!";
const logout = "Are you sure you want to logout?";
const services = "Use one of the services below to continue using $appName.";
const google = "Continue with Google";
const usedData =
    "By continuing, you agree to $appName's Terms of Services & Privacy Policy";

const loading = "Please wait while we do our magic";

/*

  DASHBOARD PAGE

*/

const dashboard = "Dashboard";
const notes = "Notes";
const reminders = "Reminders";

const notesRoute = "Note";
const remindersRoute = "Reminder";

const welcome = {
  "Welcome back,",
  "Glad to see you,",
  "We love you,",
  "Greetings,",
  "We are here for you,",
  "Everything for you,",
};

const info = {
  "Reminders only work on mobile.\nYou can add / remove one from the web, but the notification will still be visable on mobile.",
  "You can download $appName on iOS or Android for free!",
  "$appName is free and open-source. You can contribute on GitHub.",
  "The app is still in beta. Please report any bugs on the GitHub page!",
};

/*

  ADD A REMINDER PAGE

*/

const addReminder = "Let's add a new reminder!";
const chooseReminderTitle = "Name your reminder:";
const selectReminderType = "Should the reminder repeat itself?";

const List<String> repeatOptions = [
  'Minute(s)',
  'Hour(s)',
  'Day(s)',
];

const every = "Every";
const date = "Date";
const time = "Time";

const reminderWithoutName = "Please name your reminder.";

/*

  ADD A NOTE PAGE

*/

const addNote = "Hey, let's keep track of your notes!";
const chooseNoteTitle = "We should start by naming your note:";
const enterNoteContent =
    "Fill in your note content down below.\nYou can use the markup language called Markdown.";

const noteWithoutName = "Please name your note.";
const noteWithoutContent = "Please add content to your note.";