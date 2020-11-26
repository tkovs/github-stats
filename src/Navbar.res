@react.component
let make = (~submit) => {
  let (login, setLogin) = React.useState(_ => "")
  let user = UserContext.useUser()

  let onSubmit = (e: ReactEvent.Form.t): unit => {
    ReactEvent.Form.preventDefault(e)
    login->submit
  }

  let isLoading = switch user {
  | Loading => true
  | _ => false
  }

  <div className="ui menu ">
    <div className="header item"> {"Github Status"->React.string} </div>
    <div className="right item">
      <div className="ui action input">
        <form onSubmit>
          <div className="ui action input">
            <input
              type_="text"
              value=login
              placeholder="Search for..."
              onChange={e => (e->ReactEvent.Form.target)["value"] |> setLogin}
              maxLength=64
            />
            <button className={"ui button" ++ (isLoading ? " loading" : "")}>
              {"Find"->React.string}
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
}
