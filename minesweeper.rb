# frozen_string_literal: true

require 'pry'

class Board
  BOARD_FIELDS = ['|', '+', '-', '*'].freeze
  HEADER_FIELDS = ['+', '-'].freeze

  def self.transform(*args)
    new(*args).transform
  end

  def initialize(board)
    @board = board.map { |str| str.split(//) }
  end

  def transform
    raise ArgumentError unless valid_structure?
    raise ArgumentError unless valid_board?
    raise ArgumentError unless valid_characters?

    process_board
  end

  private

  def valid_structure?
    @board.all? { |a| a.size == @board.first.size }
  end

  def valid_board?
    header = @board[0] + @board[-1] - HEADER_FIELDS
    body = @board[1..-2].all? { |a| a.first == '|' && a.last == a.first }
    header.empty? && body
  end

  def valid_characters?
    reduced_board = @board.flatten - BOARD_FIELDS - [' ']
    reduced_board.empty?
  end

  def process_board
    @board.each_with_index do |row, line|
      row.each_with_index do |field, col|
        next if BOARD_FIELDS.include?(field)

        @board[line][col] = count_bombs(line, col).to_s
      end
    end
    @board.map(&:join)
  end

  def count_bombs(line, col)
    bombs_found = 0
    square_area = [
      # LEFT and RIGHT
      [line - 1, col], [line + 1, col],
      # ABOVE and BELOW
      [line, col - 1], [line, col + 1],
      # ALL 4 DIAGONALS
      [line - 1, col - 1], [line + 1, col - 1],
      [line - 1, col + 1], [line + 1, col + 1]
    ]
    square_area.each do |square|
      bombs_found += 1 if @board.send(:[], square[0]).send(:[], square[1]) == '*'
    end
    bombs_found.positive? ? bombs_found : ' '
  end
end
