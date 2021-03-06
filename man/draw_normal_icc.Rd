% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/draw_normal_icc.R
\name{draw_normal_icc}
\alias{draw_normal_icc}
\title{Draw normal data with fixed intra-cluster correlation.}
\usage{
draw_normal_icc(mean = 0, N = NULL, clusters, sd = NULL,
  sd_between = NULL, ICC = NULL)
}
\arguments{
\item{mean}{A number or vector of numbers, one mean per cluster. If none is
provided, will default to 0.}

\item{N}{(Optional) A number indicating the number of observations to be
generated. Must be equal to length(clusters) if provided.}

\item{clusters}{A vector of factors or items that can be coerced to
clusters; the length will determine the length of the generated data.}

\item{sd}{A number or vector of numbers, indicating the standard deviation of
each cluster's error terms -- standard deviation within a cluster (default 1)}

\item{sd_between}{A number or vector of numbers, indicating the standard deviation
between clusters.}

\item{ICC}{A number indicating the desired ICC.}
}
\value{
A vector of numbers corresponding to the observations from
the supplied cluster IDs.
}
\description{
Data is generated to ensure inter-cluster correlation 0, intra-cluster
correlation in expectation ICC. The data generating process
used in this function is specified at the following URL:
\url{https://stats.stackexchange.com/questions/263451/create-synthetic-data-with-a-given-intraclass-correlation-coefficient-icc}
}
\details{
The typical use for this function is for a user to provide an \code{ICC} and,
optionally, a set of within-cluster standard deviations, \code{sd}. If the
user does not provide \code{sd}, the default value is 1. These arguments
imply a fixed between-cluster standard deviation.

An alternate mode for the function is to provide between-cluster standard
deviations, \code{sd_between}, and an \code{ICC}. These arguments imply
a fixed within-cluster standard deviation.

If users provide all three of \code{ICC}, \code{sd_between}, and
\code{sd}, the function will warn the user and use the provided standard
deviations for generating the data.
}
\examples{

# Divide observations into clusters
clusters = rep(1:5, 10)

# Default: unit variance within each cluster
draw_normal_icc(clusters = clusters, ICC = 0.5)

# Alternatively, you can specify characteristics:
draw_normal_icc(mean = 10, clusters = clusters, sd = 3, ICC = 0.3)

# Can specify between-cluster standard deviation instead:
draw_normal_icc(clusters = clusters, sd_between = 4, ICC = 0.2)

# Verify that ICC generated is accurate
corr_draw = draw_normal_icc(clusters = clusters, ICC = 0.4)
summary(lm(corr_draw ~ as.factor(clusters)))$r.squared

}
