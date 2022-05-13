let assert_string_failure (res, expected : test_exec_result * string) : unit =
  let expected = Test.eval expected in
  match res with
  | Fail (Rejected (actual,_)) -> assert (Test.michelson_equal actual expected)
  | Fail (Balance_too_low p) -> failwith "contract failed: balance too low"
  | Fail (Other s) -> failwith s
  | Success _gas -> failwith "contract did not failed but was expected to fail"

let assert_success (res : test_exec_result) : unit =
  match res with
  | Fail (Rejected (actual,_)) -> failwith "Rejected action"
  | Fail (Balance_too_low p) -> failwith "contract failed: balance too low"
  | Fail (Other s) -> failwith s
  | Success _gas -> ()
