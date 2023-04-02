# frozen_string_literal: true

require 'pry'

class Board
  BOARD_FIELDS = ['|', '+', '-', '*'].freeze

  def self.transform(*args)
    new(*args).transform
  end

  def initialize(board)
    @board = board.map { |str| str.split(//) }
  end

  def transform
    # TODO: raise exception if any character is not acceptable
    # TODO: raise exception if board matrix is wrong
    process_board
  end

  private

  def process_board
    @board.each_with_index do |row, line|
      row.each_with_index do |field, column|
        next if BOARD_FIELDS.include?(field)

        @board[line][column] = count_bombs(line, column).to_s
      end
    end
    @board.map(&:join)
  end

  def count_bombs(line, column)
    bombs_found = 0
    square_area = [
      # LEFT and RIGHT
      [line - 1, column], [line + 1, column],
      # ABOVE and BELOW
      [line, column - 1], [line, column + 1],
      # ALL 4 DIAGONALS
      [line - 1, column - 1], [line + 1, column - 1],
      [line - 1, column + 1], [line + 1, column + 1]
    ]
    square_area.each do |square|
      bombs_found += 1 if @board.send(:[], square[0]).send(:[], square[1]) == '*'
    end
    bombs_found.positive? ? bombs_found : ' '
  end
end
