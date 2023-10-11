# Q1.
# 次の動作をする A1 class を実装する
# - "//" を返す "//"メソッドが存在すること

class A1
  define_method("//") { "//" }
end

# Q2.
# 次の動作をする A2 class を実装する
# - 1. "SmartHR Dev Team"と返すdev_teamメソッドが存在すること
# - 2. initializeに渡した配列に含まれる値に対して、"hoge_" をprefixを付与したメソッドが存在すること
# - 2で定義するメソッドは下記とする
#   - 受け取った引数の回数分、メソッド名を繰り返した文字列を返すこと
#   - 引数がnilの場合は、dev_teamメソッドを呼ぶこと
# - また、2で定義するメソッドは以下を満たすものとする
#   - メソッドが定義されるのは同時に生成されるオブジェクトのみで、別のA2インスタンスには（同じ値を含む配列を生成時に渡さない限り）定義されない

class A2
  def dev_team = "SmartHR Dev Team"
  
  def initialize(ary)
    ary.each do |name|
      method_name = "hoge_#{name}"
      define_singleton_method(method_name) do |times|
        times.nil? ? dev_team : method_name * times
      end
    end
  end
end

# Q3.
# 次の動作をする OriginalAccessor モジュール を実装する
# - OriginalAccessorモジュールはincludeされたときのみ、my_attr_accessorメソッドを定義すること
# - my_attr_accessorはgetter/setterに加えて、boolean値を代入した際のみ真偽値判定を行うaccessorと同名の?メソッドができること


# give up!!!!解けなかった。。。。
module OriginalAccessor
  def self.included(base)
    base.define_singleton_method(:my_attr_accessor) do |attr|
      base.define_method attr do
        @my_attr_accessor&.fetch(attr) { nil }
      end

      base.define_method "#{attr}=" do |value|
        (@my_attr_accessor ||= {})[attr] = value

        if value.is_a?(TrueClass) || value.is_a?(FalseClass)
          define_singleton_method "#{attr}?" do
            !!value
          end
        end
      end
    end
  end
end