module QueryResult = ApolloClient.Types.QueryResult;

module UserQuery = [%graphql
  {|
    query User ($login: String!) {
      user(login: $login) {
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
              let name =
                switch (user) {
                | Some(user) =>
                  switch (user.name) {
                  | Some(name) => name
                  | None => "<Without name>"
                  }
                | None => "User non existent"
                };

              <h1> {React.string(name)} </h1>;
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
