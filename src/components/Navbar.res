@react.component
let make = (~submit) => {
  let (login, setLogin) = React.useState(_ => "")

  let onSubmit = (e: ReactEvent.Form.t): unit => {
    ReactEvent.Form.preventDefault(e)
    login->submit
  }

  <>
    <div className="ui padded grid">
      <div className="ui borderless top fixed fluid menu">
        <div className="header item"> {"Github Status"->React.string} </div>
        <div className="right item">
          <div className="ui action input">
            <form onSubmit>
              <div className="ui icon input">
                <i className="search icon" />
                <input
                  type_="text"
                  value=login
                  placeholder="Search for..."
                  onChange={e => (e->ReactEvent.Form.target)["value"] |> setLogin}
                  maxLength=64
                />
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </>
}
