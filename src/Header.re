[@react.component]
let make = () => {
  let user = UserContext.useUser();

  switch (user) {
  | NotInitialized => <p> "Not initialized"->React.string </p>
  | Loading => <p> "Loading"->React.string </p>
  | Error => <p> "Error"->React.string </p>
  | User(user) =>
    let company =
      switch (user.company) {
      | Some(company) => <p> {("Works at " ++ company)->React.string} </p>
      | None => React.null
      };
    let bio =
      switch (user.bio) {
      | Some(bio) => <p> {("Bio: " ++ bio)->React.string} </p>
      | None => React.null
      };
    let name =
      <h2>
        {Belt.Option.getWithDefault(user.name, "<no name>")->React.string}
      </h2>;
    let email = <p> user.email->React.string </p>;
    let image = <img src={user.avatarUrl} />;
    let location =
      switch (user.location) {
      | Some(location) => <p> {("Lives in " ++ location)->React.string} </p>
      | None => React.null
      };

    <div> name email bio company location image </div>;
  };
};
