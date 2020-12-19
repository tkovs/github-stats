%%raw(`require('./styles/search.css')`)

module UserFragment = %relay.fragment(
  `
    fragment SearchUserFragment on User {
      login
      name
    }
  `
)

module SearchFragment = %relay.fragment(
  `
    fragment SearchSearchFragment on Query
    @refetchable(queryName: "SearchUserRefetchQuery") {
      search (type: USER, query: $term, first: 5){
        nodes {
          __typename
          ...SearchUserFragment
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

  switch searchFragment.search.nodes {
  | None => ()
  | Some(nodes) => {
      let users =
        nodes
        ->Belt.Array.keepMap(node => node)
        ->Belt.Array.map(node => UserFragment.use(node.fragmentRefs))

      Js.log(users)
    }
  }

  let onSubmit = (e: ReactEvent.Form.t): unit => {
    ReactEvent.Form.preventDefault(e)
    login->submit
  }

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
        <div className="ui left icon input large fluid">
          <i className="user icon" />
          <input
            type_="text"
            name="login"
            value=login
            placeholder="Find a user by the login"
            onChange={e => {
              startTransition(() => {
                let newLogin = (e->ReactEvent.Form.target)["value"]
                setLogin(newLogin)

                let _ = refetch(
                  ~variables=SearchFragment.makeRefetchVariables(~term=newLogin, ()),
                  (),
                )
              })
            }}
            maxLength=64
          />
        </div>
      </form>
    </div>
  </div>
}
