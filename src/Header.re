[@react.component]
let make = () => {
  let user = UserContext.useUser();

  switch (user) {
  | NotInitialized => <p> "Not initialized"->React.string </p>
  | Loading => <p> "Loading"->React.string </p>
  | Error =>
    <p> "Error on fetch... Maybe this login is not used."->React.string </p>
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
    let repoTypes =
      <p>
        {(
           "Repositories types(forked/owned) :"
           ++ string_of_int(user.forkedRepositoriesCount)
           ++ "/"
           ++ string_of_int(user.notForkedRepositoriesCount)
         )
         ->React.string}
      </p>;
    let image = <img src={user.avatarUrl} />;
    let location =
      switch (user.location) {
      | Some(location) => <p> {("Lives in " ++ location)->React.string} </p>
      | None => React.null
      };
    let twitterUsername =
      switch (user.twitterUsername) {
      | Some(twitterUsername) =>
        <p> {("Twitter: " ++ twitterUsername)->React.string} </p>
      | None => React.null
      };
    let website =
      switch (user.websiteUrl) {
      | Some(url) => <a href=url> "Website"->React.string </a>
      | None => React.null
      };

    <div>
      name
      email
      bio
      company
      website
      twitterUsername
      location
      repoTypes
      image
    </div>;
  };
};
