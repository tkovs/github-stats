module QueryResult = ApolloClient.Types.QueryResult;

module UserQuery = [%graphql
  {|
    query User ($login: String!) {
      user(login: $login) {
        name
        avatarUrl
      }
    }
  |}
];

[@react.component]
let make = () => {
  let (login, setLogin) = React.useState(_ => "");
  let queryResult = UserQuery.use({login: login});

  <div>
    <input
      type_="text"
      onChange={e => e->ReactEvent.Form.target##value |> setLogin}
    />
    {switch (queryResult) {
     | {loading: true, data: None} => <p> "Loading"->React.string </p>
     | {loading, data: Some({user}), error} =>
       <>
         <dialog>
           {loading ? <p> {React.string("Refreshing...")} </p> : React.null}
           {switch (error) {
            | Some(_) =>
              <p>
                "Something went wrong, data may be incomplete"->React.string
              </p>
            | None => React.null
            }}
         </dialog>
         <p>
           {if (login !== "") {
              let name =
                switch (user) {
                | Some(user) =>
                  Belt.Option.getWithDefault(user.name, "<Without name>")
                | None => "User non existent"
                };
              let avatarUrl =
                switch (user) {
                | Some(user) => Some(user.avatarUrl)
                | None => None
                };

              let name = <h1> {React.string(name)} </h1>;
              let avatarSome =
                Belt.Option.getWithDefault(
                  avatarUrl,
                  Js.Json.string(
                    "https://avatars0.githubusercontent.com/u/191074?s=460&v=4",
                  ),
                );
              let avatarImg =
                <img
                  src={Js.String2.replace(
                    Js.Json.stringify(avatarSome),
                    "\"",
                    "",
                  )}
                />;

              <div>
                name
                {Belt.Option.isSome(user) ? avatarImg : React.null}
              </div>;
            } else {
              React.null;
            }}
         </p>
       </>
     | {loading: false, data: None} =>
       <p> "Error loading data"->React.string </p>
     }}
  </div>;
};
