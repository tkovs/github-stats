%%raw(`require('./styles/index.css')`)
%%raw(`require('vtex-tachyons/tachyons.css')`)

module Query = %relay.query(
  `
    query AppUserQuery ($login: String!) {
      user(login: $login) {
        avatarUrl
        bio
        company
        createdAt
        email
        followers {
          totalCount
        }
        following {
          totalCount
        }
        location
        login
        name
        twitterUsername
        starredRepositories {
          totalCount
        }
        websiteUrl
        forkedRepositories: repositories(isFork: true) {
          totalCount
        },
        notForkedRepositories: repositories(isFork: false) {
          totalCount
        }
      }
    }
  `
)

@react.component
let make = () => {
  let (login, setLogin) = React.useState(_ => "tkovs")
  let user = Query.use(~variables={login: login}, ())

  <div>
    <Navbar submit={value => setLogin(_ => value)} />
    {switch user {
    | {user: None} => React.null
    | {user: Some(user)} => <div className="ui container grid"> <Sidebar user /> <Content /> </>
    }}
  </div>
}
