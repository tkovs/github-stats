%%raw(`require('./styles/search.css')`)

module SearchFragment = %relay.fragment(
  `
    fragment SearchSearchFragment on Query
    @refetchable(queryName: "SearchUserRefetchQuery") {
      search (type: USER, query: $term, first: 5){
        nodes {
          __typename
          ...DumbUserFragment
        }
      }
    }
  `
)

module Query = %relay.query(
  `
    query SearchUserQuery ($term: String!) { 
      ...SearchSearchFragment
    }
  `
)

@react.component
let make = (~submit) => {
  let (login, setLogin) = React.useState(_ => "")
  let query = Query.use(~variables={term: ""}, ())
  let (searchFragment, refetch) = SearchFragment.useRefetchable(query.fragmentRefs)
  let (startTransition, _) = ReactExperimental.unstable_useTransition()
  let (searches, setSearches) = React.useState(_ => [""])
  Js.log(searches)

  let updateSearch = result => {
    setSearches(searches => {
      Belt.Array.concat(searches, result)
    })
  }

  let onSubmit = (e: ReactEvent.Form.t): unit => {
    ReactEvent.Form.preventDefault(e)
    login->submit
  }

  let components = React.useMemo1(_ => {
    switch searchFragment.search.nodes {
    | None => [React.null]
    | Some(nodes) =>
      nodes
      ->Belt.Array.keepMap(node => node)
      ->Belt.Array.mapWithIndex((index, node) =>
        <Dumb key={login ++ string_of_int(index)} user=node.fragmentRefs submit=updateSearch />
      )
    }
  }, [login])

  <div className="ui middle aligned centered grid" id="search">
    <div className="fourteen wide mobile eight wide tablet four wide computer column">
      <img
        className="ui image small centered"
        src="https://github.githubassets.com/images/modules/logos_page/Octocat.png"
      />
      <h2 className="ui header centered">
        <div className="content"> {React.string("Githubr")} </div>
      </h2>
      <form className="ui fluid" onSubmit>
        <div className="ui category search">
          <div className="ui left icon input large fluid">
            <input
              className="prompt"
              type_="text"
              name="login"
              placeholder="Find a user by the login"
              onChange={e => {
                startTransition(() => {
                  let newLogin = (e->ReactEvent.Form.target)["value"]
                  setLogin(newLogin)
                  setSearches(_ => [])

                  refetch(
                    ~variables=SearchFragment.makeRefetchVariables(~term=newLogin, ()),
                    (),
                  ) |> ignore
                })
              }}
              maxLength=64
            />
            <i className="search icon" />
          </div>
          <div className="results" />
        </div>
        {ReasonReact.array(components)}
      </form>
    </div>
  </div>
}
