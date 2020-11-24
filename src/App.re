module UserQuery = [%graphql
  {|
    query User ($login: String!) {
      user(login: $login) {
        avatarUrl
        bio
        company
        createdAt
        email
        location
        name
        twitterUsername
        websiteUrl
        forkedRepositories: repositories(isFork: true) {
          totalCount
        },
        notForkedRepositories: repositories(isFork: false) {
          totalCount
        }
      }
    }
  |}
];

let removeQuotationMarks = url => {
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
              avatarUrl:
                user.avatarUrl->Js.Json.stringify->removeQuotationMarks,
              bio: user.bio,
              company: user.company,
              createdAt:
                Js.Json.stringify(user.createdAt)
                ->removeQuotationMarks
                ->Js.Date.fromString,
              email: user.email,
              forkedRepositoriesCount: user.forkedRepositories.totalCount,
              location: user.location,
              name: user.name,
              notForkedRepositoriesCount:
                user.notForkedRepositories.totalCount,
              twitterUsername: user.twitterUsername,
              websiteUrl:
                switch (user.websiteUrl) {
                | Some(url) =>
                  Some(url->Js.Json.stringify->removeQuotationMarks)
                | None => None
                },
            };
            User(data);
          | None => NotInitialized
          }
        | {loading: true} => Loading
        | {error: Some(_)} => Error
        }
      );

  let debouncedSetLogin = Debouncer.make(~wait=500, setLogin);

  <div>
    <UserProvider value>
      <input
        type_="text"
        onChange={e => e->ReactEvent.Form.target##value |> debouncedSetLogin}
        maxLength=64
      />
      <Header />
    </UserProvider>
  </div>;
};
