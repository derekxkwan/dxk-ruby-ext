class Array
  def normalize
    cur_max = self.max
    return self.map{|i| i.to_f/cur_max}
  end

  def pdf
    cur_sum = self.inject(0, :+)
    return self.map{|i| i.to_f/cur_sum}
  end
  
  def cdf
    cur_sum = 0
    return self.map{|i| cur_sum += i}.normalize
  end

  def wsample(weight_arr, num = 1)
    cur_len = self.length
    w_len = weight_arr.length
    ret = []
    num = (num > cur_len ? cur_len : (num < 1 ? 1 : num)).to_i

    weight_arr = weight_arr + [0] * (cur_len - w_len) if w_len < cur_len
    
    normalized = weight_arr[0..cur_len].cdf
    num.times do
      idx = num -1
      cur_rand = rand()
      normalized.each_with_index do |val, i|
        idx = i
        if cur_rand < val
          idx = i
          break
        end
      end
      ret =ret + [self[idx]]
    end
    if num <= 1
      return ret[0]
    else
      return ret
    end
  end
end
 
