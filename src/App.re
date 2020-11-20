[@react.component]
let make = () => {
  <ApolloClient.React.ApolloProvider client=Client.instance>
    <h2> {React.string("Github Stats")} </h2>
    <User />
  </ApolloClient.React.ApolloProvider>;
};
