#Quiz: Lesson 1

**QUESTION #1**

a=1

**QUESTION #2**

Array data structure has the ordered index feature.
Hash data structure has key:value feature.

**QUESTION #3**

arr = [1, 2, 3, 3] 
> return [1,2,3,3]

[1, 2, 3, 3].uniq
> [1,2,3]

[1, 2, 3, 3].uniq!
> [1,2,3]

**QUESTION #4**

Array map method will focus on every element, you can manipulate every single element according some business logic and return a new array.
> arr = [['a',1], ['b',2], ['c',3]]
    new_arr = arr.map { |e| e[1]+100 } 
    new_arr will be [101, 102, 103]

Array select method will return a new array which match the specific criteria and the data structure is the same as origianl one.
> arr =  [['a',1], ['b',2], ['c',3]]
   new_arr = arr.select { |e| e[1] > 2}
   new_arr = [['c',3]]    
     
  
    
**QUESTION #5**

Hash with string object as key.
> ex: {"string"=>1}
  ex: h={}; h["string"]=1
  
**QUESTION #6**

The return value is "no way!"

**QUESTION #7**

The return value is "4"

**QUESTION #8**
x is undefiend local variable, will pop up error.
> NoMethodError: undefined method `+' for nil:NilClass