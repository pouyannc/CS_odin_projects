def merge_sort(arr1, arr_merged = [])
  return arr1 if arr1.length <= 1 
  
  arr2 = arr1.pop(arr1.length/2)
  arr1 = merge_sort(arr1)
  arr2 = merge_sort(arr2)

  loop do
    arr1[0] < arr2[0] ? arr_merged.push(arr1.shift) : arr_merged.push(arr2.shift)
    if arr1.empty? 
      arr_merged.push(arr2)
      break
    elsif arr2.empty?
      arr_merged.push(arr1)
      break
    end
  end

  arr_merged.flatten
end

p merge_sort([9,8,7,6,5,4,3,2,1])
