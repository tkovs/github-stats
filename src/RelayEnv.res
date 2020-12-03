/* This is just a custom exception to indicate that something went wrong. */
exception Graphql_error(string)
@ocaml.doc(
  "
 * A standard fetch that sends our operation and variables to the
 * GraphQL server, and then decodes and returns the response.
 "
)
let fetchQuery: ReasonRelay.Network.fetchFunctionPromise = (operation, variables, _cacheConfig) => {
  open Fetch
  fetchWithInit(
    "https://api.github.com/graphql",
    RequestInit.make(
      ~method_=Post,
      ~body=Js.Dict.fromList(list{
        ("query", Js.Json.string(operation.text)),
        ("variables", variables),
      })
      |> Js.Json.object_
      |> Js.Json.stringify
      |> BodyInit.make,
      ~headers=HeadersInit.make({
        "Authorization": "bearer " ++ Environment.token,
      }),
      (),
    ),
  ) |> Js.Promise.then_(resp =>
    if Response.ok(resp) {
      Response.json(resp)
    } else {
      Js.Promise.reject(Graphql_error("Request failed: " ++ Response.statusText(resp)))
    }
  )
}
let network = ReasonRelay.Network.makePromiseBased(~fetchFunction=fetchQuery, ())
let environment = ReasonRelay.Environment.make(
  ~network,
  ~store=ReasonRelay.Store.make(
    ~source=ReasonRelay.RecordSource.make(),
    ~gcReleaseBufferSize=10, // This sets the query cache size to 10
    (),
  ),
  (),
)
