module UserQuery = [%graphql
  {|
    query User ($login: String!) {
      user(login: $login) {
        avatarUrl
        bio
        company
        email
        location
        name
      }
    }
  |}
];

[@react.component]
let make = () => {
  let (login, setLogin) = React.useState(_ => "");
  let queryResult = UserQuery.use({login: login});

  let value =
    login === ""
      ? UserContext.NotInitialized
      : (
        switch (queryResult) {
        | {error: None, loading: false, data: None} => NotInitialized
        | {error: None, loading: false, data: Some({user})} =>
          switch (user) {
          | Some(user) =>
            let data: UserContext.user = {
              avatarUrl:
                user.avatarUrl
                ->Js.Json.stringify
                ->Js.String2.replace(_, "\"", ""),
              bio: user.bio,
              company: user.company,
              email: user.email,
              location: user.location,
              name: user.name,
            };
            User(data);
          | None => NotInitialized
          }
        | {loading: true, _} => Loading
        | {error: Some(_), _} => Error
        }
      );

  <div>
    <UserProvider value>
      <input
        type_="text"
        onChange={e => e->ReactEvent.Form.target##value |> setLogin}
      />
      <Header />
    </UserProvider>
  </div>;
};
