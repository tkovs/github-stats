type user = {
  avatarUrl: string,
  bio: option(string),
  company: option(string),
  forkedRepositoriesCount: int,
  email: string,
  location: option(string),
  name: option(string),
  notForkedRepositoriesCount: int,
  twitterUsername: option(string),
  websiteUrl: option(string),
};

type graphqlQuery =
  | NotInitialized
  | Loading
  | Error
  | User(user);

let context = React.createContext(NotInitialized);
let useUser = () => React.useContext(context);
