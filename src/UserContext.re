type user = {
  name: option(string),
  avatarUrl: string,
  bio: option(string),
  company: option(string),
};

type graphqlQuery =
  | NotInitialized
  | Loading
  | Error
  | User(user);

let context = React.createContext(NotInitialized);
let useUser = () => React.useContext(context);
