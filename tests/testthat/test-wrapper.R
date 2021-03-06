context("wrapper")

# grab the feed for portland's biketown... these feeds
# change regularly, so test failures might result from
# changes in the operation model of biketown rather than
# failure of the software
biketown <- get_gbfs("biketown_pdx")
bike_itau <- get_gbfs("santiago")
bird <- get_gbfs("https://mds.bird.co/gbfs/chicago/gbfs.json")



test_that("main wrapper works", {
 
  skip_if_offline(host = "r-project.org")
  
  expect_equal(class(biketown), "list")
  expect_equal(class(bike_itau), "list")
  expect_equal(class(bird), "list")
  
})

test_that("argument checking works", {

  skip_if_offline(host = "r-project.org")
  
  # no directory supplied but user wants to save
  expect_error(get_gbfs("biketown_pdx", 
                        output = "save"),
               "The argument to output suggests")
  
})
