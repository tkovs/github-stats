[@react.component]
let make = () => {
  let user = UserContext.useUser();

  switch (user) {
  | NotInitialized => <p> "Not initialized"->React.string </p>
  | Loading => <p> "Loading"->React.string </p>
  | Error => <p> "Error"->React.string </p>
  | User(user) =>
    <div> <p> user.name->React.string </p> <img src={user.avatarUrl} /> </div>
  };
};
