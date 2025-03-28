test_that("creating a multiagent object from files on disk works", {

  # Read from a directory containing 18 RDS files generated by
  # the `x_write_disk()` function
  multiagent <-
    read_disk_multiagent(
      pattern = ".*rds",
      path = "tests_rds_files"
    )

  # Expect a multiagent object of class `ptblank_multiagent`
  expect_s3_class(multiagent, "ptblank_multiagent")

  # Expect that names in a multiagent object match a
  # prescribed set of names
  expect_true(all(names(multiagent) == c("overview_tbl", "agents")))

  # Expect that `multiagent$agents` has a length of 18
  # (one for each agent contained within)
  expect_length(multiagent$agents, 18)

  for (i in seq_len(length(multiagent$agents))) {

    agent_i <- multiagent$agents[[i]]

    # Expect that the `validation_set` component is a `tbl_df`
    expect_s3_class(agent_i$validation_set, "tbl_df")

    # Expect certain classes for the different `ptblank_agent` components
    expect_null(agent_i$tbl)
    expect_s3_class(agent_i$read_fn, "formula")
    expect_type(agent_i$tbl_name, "character")
    expect_type(agent_i$label, "character")
    expect_type(agent_i$tbl_src, "character")
    expect_type(agent_i$tbl_src_details, "character")
    expect_type(agent_i$col_names, "character")
    expect_type(agent_i$col_types, "character")
    expect_type(agent_i$db_col_types, "character")
    expect_s3_class(agent_i$actions, "action_levels")
    expect_type(agent_i$end_fns, "list")
    expect_type(agent_i$embed_report, "logical")
    expect_type(agent_i$lang, "character")
    expect_s3_class(agent_i$time_start, "POSIXct")
    expect_s3_class(agent_i$time_end, "POSIXct")
    expect_type(agent_i$validation_set$i, "integer")
    expect_type(agent_i$validation_set$assertion_type, "character")
    expect_type(agent_i$validation_set$column, "list")
    expect_type(agent_i$validation_set$values, "list")
    expect_type(agent_i$validation_set$na_pass, "logical")
    expect_type(agent_i$validation_set$preconditions, "list")
    expect_type(agent_i$validation_set$actions, "list")
    expect_type(agent_i$validation_set$brief, "character")
    expect_type(agent_i$validation_set$active, "list")
    expect_type(agent_i$validation_set$eval_active, "logical")
    expect_type(agent_i$validation_set$eval_error, "logical")
    expect_type(agent_i$validation_set$eval_warning, "logical")
    expect_type(agent_i$validation_set$capture_stack, "list")
    expect_type(agent_i$validation_set$all_passed, "logical")
    expect_type(agent_i$validation_set$n, "double")
    expect_type(agent_i$validation_set$n_passed, "double")
    expect_type(agent_i$validation_set$n_failed, "double")
    expect_type(agent_i$validation_set$f_passed, "double")
    expect_type(agent_i$validation_set$f_failed, "double")
    expect_type(agent_i$validation_set$warn, "logical")
    expect_type(agent_i$validation_set$notify, "logical")
    expect_type(agent_i$validation_set$stop, "logical")
    expect_type(agent_i$validation_set$row_sample, "double")
    expect_type(agent_i$validation_set$tbl_checked, "list")
    expect_s3_class(agent_i$validation_set$time_processed, "POSIXct")
    expect_type(agent_i$validation_set$proc_duration_s, "double")
    expect_type(agent_i$extracts, "list")
  }

  # Expect that the `read_disk_multiagent()` function will
  # stop if the file list is empty
  expect_error(
    read_disk_multiagent(
      pattern = ".*rda",
      path = "tests_rds_files"
    )
  )

  # Expect that not supplying a path will mean the path is
  # the current working directory (which is temporarily
  # changed for this test)
  current_path <- getwd()
  setwd("tests_rds_files")
  expect_s3_class(
    read_disk_multiagent(
      pattern = ".*rds"
    ),
    "ptblank_multiagent"
  )
  setwd(current_path)
})
