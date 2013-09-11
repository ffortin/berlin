require 'berlin-ai'         # Require the berlin-ai library.

def compute_score(node)
  node.soldiers_per_turn + node.points
end

def better_node(node1, node2)
  return node1 if node2.nil?
  return node2 if node1.nil?
  compute_score(node1) > compute_score(node2) ? node1 : node2
end


class Berlin::AI::Player

  def self.on_turn(game)
    game.map.controlled_nodes.each do |node|

      soldiers = node.number_of_soldiers

      soldiers_to_keep = compute_score(node) > 0 ? (soldiers / 2.0).ceil : 0;
      soldiers_to_send = soldiers - soldiers_to_keep

      winner_node = nil

      if soldiers_to_send > 0
        node.adjacent_nodes.shuffle.each do |other_node|
          winner_node = better_node(other_node, winner_node)
          #winner_node = other_node
        end
        puts "We have a WINNER NODE %p" % winner_node.type
        game.add_move(node, winner_node, soldiers_to_send)
      end

    end
  end
end
