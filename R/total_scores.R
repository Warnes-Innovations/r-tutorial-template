total_scores <- function(df_scores, high=c("better", "worse"))
{
  high <- match.arg(high)
  if(!is.data.frame(df_scores))
    stop("Expected a data frame object for `df_scores")

  required_cols <- c("participant_id", "set_num", "toss_in_set", "toss_score")
  if(all(required_cols %in% colnames(df_scores)) == FALSE) {
    missing_cols <- !(required_cols %in% colnames(df_scores))
    missing_names <- required_cols[missing_cols]
    stop("Missing necessary columns: ",
         paste("'", missing_names, "'",
               sep='',
               collapse=", "
         )
    )
  }

  retval <- df_scores |>
    left_join(total_score, by = "participant_id") |>
    group_by(set_num, participant_id) |>
    filter( row_number() == 1) |>
    ungroup() |>
    group_by(set_num) |>
    mutate(
      rank = row_number()
    ) |>
    ungroup() |>
    group_by(participant_id) |>
    summarise(
      total_score  = first(total_score),
      average_rank = mean(rank)
    )

  if (high == "better") {
    retval <- retval |> arrange(desc(total_score))
  } else if (high=="worse")
  {
    retval <- retval |> arrange(total_score)
  } else
  {
    stop("Invalid value for `high` specified:", high)
  }
  # otherwise don't change the order


  return(retval)
}
