require 'berlin-ai'         # Require the berlin-ai library.

class Berlin::AI::Player

  def self.compute_score(node)
    node.soldiers_per_turn + node.points
  end

  def self.better_node(node1, node2)
    return node1 if node2 == nil
    return node2 if node1 == nil
    Berlin::AI::Player::compute_score(node1) > Berlin::AI::Playercompute_score(node2) ? node1 : node2
  end

  def self.on_turn(game)         # Implement the on_turn method of Berlin::AI::Player.
    # Do your magic here.

    # Here's an AI that randomly moves soldiers from node to node.
    game.map.controlled_nodes.each do |node|

      soldiers = node.number_of_soldiers

      soldiers_to_keep = Berlin::AI::Player::compute_score(node) > 0 ? (soldiers / 2.0).ceil : 0;
      soldiers_to_send = soldiers - soldiers_to_keep

      winner_node = nil
      
      if soldiers_to_send > 0
        node.adjacent_nodes.shuffle.each do |other_node|
          winner_node = Berlin::AI::Player::better_node(other_node, winner_node)
          #winner_node = other_node
        end
        puts "We have a WINNER NODE %p" % winner_node.type
        game.add_move(node, winner_node, soldiers_to_send)
      end

    end
  end
end
