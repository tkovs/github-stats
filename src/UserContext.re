type user = {
  name: string,
  avatarUrl: string,
};

type graphqlQuery =
  | NotInitialized
  | Loading
  | Error
  | User(user);

let context = React.createContext(NotInitialized);
let useUser = () => React.useContext(context);
