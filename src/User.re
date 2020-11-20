module QueryResult = ApolloClient.Types.QueryResult;

module UserQuery = [%graphql
  {|
    query User ($login: String!) {
      user(login: $login) {
        id
        name
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
              switch (user) {
              | Some(user) =>
                switch (user.name) {
                | Some(name) => React.string(name)
                | None => React.string("<Without name>")
                }
              | None => React.string("User non existent")
              };
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
