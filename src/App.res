module Query = %relay.query(
  `
    query AppUserQuery ($login: String!) {
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
  `
)

@react.component
let make = () => {
  let (login, setLogin) = React.useState(_ => "")
  let user = Query.use(~variables={login: login}, ())

  <div> <Navbar submit={value => setLogin(_ => value)} /> <div> <Sidebar /> </div> </div>
}
