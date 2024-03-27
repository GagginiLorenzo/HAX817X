set.seed(1)
data <- read.csv("~/Travaille/HAX817X/rho_0/1.csv")
Variables=data[]
sklearn <- import("sklearn", convert = FALSE)

########
compute_marginal <- function(sim_data,
                             prob_type = "regression",
                             list_grps = list(),
                             seed,
                             ...) {
  print("Applying Marginal Method")
  set.seed(seed)
  # Splitting train/test sets
  train_ind <- sample(length(sim_data$y), size = length(sim_data$y) * 0.8)
  #print(train_ind)
  marginal_imp <- numeric()
  marginal_pval <- numeric()
  score_val <- 0
  if (length(list_grps) == 0)
    indices = paste0("x", 1:ncol(sim_data[, -1]))
  else
    indices = list_grps
  
  count_ind = 1
  if (prob_type == "classification") {
    sim_data$y <- as.factor(sim_data$y)
    for (i in indices) {
      i = paste0(i, collapse="+")
      fit <- glm(formula(paste0("y ~ ", i)),
                 data = sim_data[train_ind, ],
                 family = binomial()
      )
      sum_fit <- summary(fit)
      marginal_imp[count_ind] <- coef(sum_fit)[, 1][[2]]
      marginal_pval[count_ind] <- coef(sum_fit)[, 4][[2]]
      pred <- predict(fit, newdata = sim_data[-train_ind, -1], type="response")
      score_val <- score_val +
        py_to_r(sklearn$metrics$roc_auc_score(sim_data$y[-train_ind], pred))
      count_ind <- count_ind + 1
    }
  }
  
  if (prob_type == "regression") {
    sim_data$y <- as.numeric(sim_data$y)
    for (i in indices) {
      i = paste0(i, collapse="+")
      print(paste0("y ~ ", i))
      fit <- glm(formula(paste0("y ~ ", i)),
                 data = sim_data[train_ind, ]
      )
      sum_fit <- summary(fit)
      marginal_imp[count_ind] <- coef(sum_fit)[, 1][[2]]
      marginal_pval[count_ind] <- coef(sum_fit)[, 4][[2]]
      pred <- predict(fit, newdata = sim_data[-train_ind, -1])
      score_val <- score_val + py_to_r(sklearn$metrics$r2_score(sim_data$y[-train_ind], pred))
      print(score_val)
      print(marginal_imp[count_ind])
      count_ind <- count_ind + 1
    }
  }
  
  return(data.frame(
    method = "Marg",
    importance = marginal_imp,
    p_value = marginal_pval,
    score = score_val / ncol(sim_data[, -1])
  ))
}
#############
generate_grps <- function(p, n_grps) {
  list_grps <- list()
  items_per_grp <- p / n_grps
  for (i in c(1:p)) {
    if ((i-1) == 0) {
      curr_list <- paste0("x", i)
    }
    else {
      if ((i-1) %% items_per_grp == 0) {
        list_grps[[length(list_grps)+1]] <- curr_list
        curr_list <- paste0("x", i)
      }
      else
        curr_list <- c(curr_list, paste0("x", i))
    }
  }
  list_grps[[length(list_grps)+1]] <- curr_list
  list_grps
}
#############
glist=generate_grps(50,10)
compute_marginal(data,list_grps = glist,seed=1)
