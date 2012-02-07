# TODO:
# - scores
#   I.e fuzzy {:first_name => 1, :last_name => 2}, last_name gives double score
#   Currently everything gets scored with 1
# - weighting of fuzzy_find results

module NoFuzz
  def self.included(model)
    model.extend ClassMethods
    model.has_many :trigrams, :class_name => model.trigram_model
  end

  module ClassMethods

    def fuzzy(*fields)
      @fuzzy_fields = fields
      @fuzzy_ref_id = "rss_feed_datum_id"
      #@fuzzy_ref_id = reflect_on_association(:trigrams).primary_key_name
      @fuzzy_trigram_model = Trigrams::RssFeedDatum #reflect_on_association(:trigrams).class_name.constantize
    end

    def populate_trigram_index
      clear_trigram_index
      
      @fuzzy_fields.each do |f|
        self.all.each do |i|
          word = ' ' + i.send(f).to_s
          (0..word.length-3).each do |idx|
            tg = word[idx,3].downcase
               # Force normalization by downcasing for now - should be overridable by the user
            @fuzzy_trigram_model.create(:tg => tg, @fuzzy_ref_id => i.id)
          end
        end
      end
      true
    end
    
    def get_fuzzy_matches(word, limit = 0)
      word = " #{word} "
      trigram_list = (0..word.length-3).collect { |idx| word[idx,3] }
      trigrams = @fuzzy_trigram_model.where(["tg IN (?)", trigram_list])
      trigrams = trigrams.group(@fuzzy_ref_id)
      trigrams = trigrams.select(@fuzzy_ref_id)
      trigrams = trigrams.order('SUM(score) DESC')
      trigrams = trigrams.includes(belongs_to_association)
      trigrams = trigrams.limit(limit) if limit > 0
      trigrams
    end

    #this just returns the ids for the records that match
    def fuzzy_find_ids(word, limit = 0)
      trigrams = get_fuzzy_matches(word, limit)
      trigrams.all.collect do |trigram|
        trigram[belongs_to_association + '_id'] 
      end
    end

    #this returns the actual records that match.
    def fuzzy_find(word, limit = 0)      
      trigrams = get_fuzzy_matches(word, limit)
      trigrams.all.collect do |trigram|
         trigram.send(belongs_to_association)
      end
    end
    

    def clear_trigram_index
      @fuzzy_trigram_model.delete_all
    end

    # def fuzzy_find(word, limit = 0)      
    #   word = " #{word} "
    #   trigram_list = (0..word.length-3).collect { |idx| word[idx,3] }
    #   trigrams = @fuzzy_trigram_model.where(["tg IN (?)", trigram_list])
    #   trigrams = trigrams.group(@fuzzy_ref_id)
    #   trigrams = trigrams.order('SUM(score) DESC')
    #   trigrams = trigrams.includes(belongs_to_association)
    #   trigrams = trigrams.limit(limit) if limit > 0
    #   trigrams.all.collect do |trigram|
    #      trigram.send(belongs_to_association)
    #   end
    # end
    
    def trigram_model
      "::Trigrams::#{self.to_s.pluralize.underscore.gsub('/', '_').classify}"
    end
    
    private
    
    def belongs_to_association
      self.to_s.demodulize.underscore.to_sym
    end

  end



end