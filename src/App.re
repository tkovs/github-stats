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
        twitterUsername
        websiteUrl
      }
    }
  |}
];

let clearUrl = url => {
  let remove = Js.String2.replace(_, "\"", "");

  url->remove->remove;
};

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
              avatarUrl: user.avatarUrl->Js.Json.stringify->clearUrl,
              bio: user.bio,
              company: user.company,
              email: user.email,
              location: user.location,
              name: user.name,
              twitterUsername: user.twitterUsername,
              websiteUrl:
                switch (user.websiteUrl) {
                | Some(url) => Some(url->Js.Json.stringify->clearUrl)
                | None => None
                },
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
