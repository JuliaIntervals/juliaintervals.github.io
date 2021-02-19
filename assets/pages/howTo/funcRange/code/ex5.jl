# This file was generated, do not modify it. # hide
range_10_intervals = reduce(∪, Y)
overestimate_1_interval = (diam(range_1_interval)-diam(range_f))/diam(range_f)
overestimate_10_intervals = (diam(range_10_intervals)-diam(range_f))/diam(range_f)
@show overestimate_1_interval, overestimate_10_intervals