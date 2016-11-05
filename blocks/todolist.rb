class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end
end

class TodoList
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end

  # rest of class needs implementation
  def add(todo)
    raise TypeError, 'can only add Todo objects' unless todo.instance_of? Todo

    @todos << todo
  end

  alias_method :<<, :add

  def size
    @todos.size
  end

  def first
    @todos.first
  end

  def last
    @todos.last
  end

  def item_at(index)
    @todos.fetch(index)
  end

  def mark_done_at(index)
    item_at(index).done!
  end

  def mark_undone_at(index)
    item_at(index).undone!
  end

  def shift
    @todos.shift
  end

  def pop
    @todos.pop
  end

  def remove_at(index)
    @todos.delete(item_at(index))
  end

  def to_s
    text = "---- #{title} ----\n"
    text << @todos.map(&:to_s).join("\n")
    text
  end

  def to_a
    @todos
  end

  def each
    @todos.each do |todo|
      yield(todo)
    end
    self
  end

  def select
    list = TodoList.new(title)
    @todos.each do |todo|
      list.add(todo) if yield(todo)
    end
    list
  end

  def find_by_title(todo_title)
    select { |todo| todo.title == todo_title}.first
  end

  def done?
    @todos.all? { |todo| todo.done? }
  end

  def done!
    @todos.each_index do |idx|
      mark_done_at(idx)
    end
  end

  def all_done
    select { |todo| todo.done?}
  end

  def all_not_done
    select { |todo| !todo.done?}
  end

  def mark_done(todo_title)
    find_by_title(todo_title) && find_by_title(todo_title).done!
  end

  def mark_all_done
    each { |todo| todo.done!}
  end

  def mark_all_undone
    each { |todo| todo.undone!}
  end
end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")
list = TodoList.new("Today's Todos")

list.add(todo1)
list.add(todo2)
list.add(todo3)

list.size

# p list.item_at(100)

# p list.mark_done_at               # raises ArgumentError
list.mark_done_at(1)            # marks the 2nd item as done
# p list.mark_done_at(100)

list.mark_undone_at(1)

# puts list.to_s

list.each do |todo|
  puts todo                   # calls Todo#to_s
end

todo1.done!

results = list.select { |todo| todo.done? }

puts results.inspect

p list.find_by_title("Buy milk")

p list.all_done

p list.all_not_done
