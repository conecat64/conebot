return function(num)
    return tostring(num):reverse():gsub('%d%d%d', '%0,'):gsub(',$', ''):reverse()
end