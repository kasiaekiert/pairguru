class TitleBracketsValidator < ActiveModel::Validator
    def validate(record)
        if record.title
            unless valid_string?(record.title)
                record.errors.add(:title, "Title contains unclosed brackets, please check")
            end
        end
    end
    
    def valid_string?(str)
        stack = []
        symbols = { '{' => '}', '[' => ']', '(' => ')' }
        str.each_char do |c|
          stack << c if symbols.key?(c)
          return false if symbols.key(c) && symbols.key(c) != stack.pop
        end
        if stack.empty?
            # If it doesn't contain unclosed brackets, checking that it also doesn't contain empty brackets
            return false if(str =~ /[\{\[\(][\}\]\)]/)
            return true
        else
            return false
        end
    end
end