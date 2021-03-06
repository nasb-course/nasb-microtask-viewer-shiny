library(testthat)

testthat::test_that('Test prepare_paea_results', {
    paea <- GeoDE::PAEAAnalysis(example_chdirresults, example_gmtfile)
    description <- extract_description(preprocess_data(example_microtask_data))
    testthat::expect_equal(
        nrow(prepare_paea_results(paea_to_df(paea), description)),
        length(paea$p_values)
    )
})


testthat::test_that('Test paea_analysis_wrapper', {
    testthat::expect_identical(
        paea_analysis_wrapper(example_chdirresults, example_gmtfile),
        GeoDE::PAEAAnalysis(example_chdirresults, example_gmtfile)
    )
})


testthat::test_that('Test paea_analysis_dispatch', {
    testthat::expect_equal(
        paea_analysis_dispatch(example_chdirresults, example_gmtfile)$down_down,
        GeoDE::PAEAAnalysis(example_chdirresults_down, example_gmtfile_down)
    )
    
    testthat::expect_equal(
        paea_analysis_dispatch(example_chdirresults, example_gmtfile)$up_up,
        GeoDE::PAEAAnalysis(example_chdirresults_up, example_gmtfile_up)
    )
})


testthat::test_that('Test split_chdirresults ', {
    chdirresults_splitted <- split_chdirresults(example_chdirresults)
    testthat::expect_true(is.list(chdirresults_splitted))
    testthat::expect_equal(length(chdirresults_splitted), 2)
    testthat::expect_equal(
        nrow(chdirresults_splitted$up[[1]][[1]]) + nrow(chdirresults_splitted$down[[1]][[1]]),
        nrow(example_chdirresults[[1]][[1]]) 
    )
})


testthat::test_that('Test split_gmtfile', {
    gmtfile_splitted <- split_gmtfile(example_gmtfile)
    testthat::expect_true(is.list(gmtfile_splitted))
    testthat::expect_equal(names(gmtfile_splitted), c('up', 'down'))
    testthat::expect_equal(
        length(gmtfile_splitted$up) + length(gmtfile_splitted$down),
        length(example_gmtfile)
    )
})