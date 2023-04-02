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
    binding.pry
  end

  private

  def process_board
    @board.each_with_index do |row, i|
      row.each_with_index do |field, j|
        next if BOARD_FIELDS.include?(field)

        @board[i][j] = count_bombs(i, j).to_s
      end
    end
    @board
  end

  def count_bombs(i, j)
    bombs_in_area = 0
  end
end
