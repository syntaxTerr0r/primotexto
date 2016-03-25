module Primotexto
  class Client
    ERROR_CODES = {
      10 => 'no phone number provided',
      11 => 'invalid phone number syntax',
      12 => 'number blacklisted unsubscribed',
      13 => 'number blacklisted user bounce',
      14 => 'number blacklisted global bounce',
      15 => 'number already exists',
      20 => 'invalid characters in sender',
      21 => 'sender too short',
      22 => 'sender too long',
      23 => 'full numeric sender not allowed',
      30 => 'no message content provided',
      31 => 'invalid characters in message',
      32 => 'message content too long',
      40 => 'invalid campaign name',
      41 => 'invalid campaign programming time',
      42 => 'campaign cannot be deleted',
      43 => 'campaign cannot be cancelled',
      44 => 'free mode campaign limit reached',
      45 => 'invalid campaign tag',
      46 => 'tag already exists',
      47 => 'campaign not found',
      48 => 'invalid campaign send list',
      60 => 'list not found',
      61 => 'invalid date format',
      70 => 'api access disabled',
      71 => 'insufficient credits',
      72 => 'authentication failed',
      91 => 'international mode needed'
    }.freeze

    API_HOST = 'api.primotexto.com'.freeze

    API_METHODS_MAP = [
      ['post_notification_message', 'post_notification_messages_send_params'],
      ['post_marketing_message', 'post_marketing_messages_send_params'],
      'get_messages_status_params',
      'get_account_stats',
      'get_messages_stats_params',
      'get_messages_replies_params',
      'get_messages_blacklists_params',
      ['get_bounces_contacts', 'get_bounces_default_contacts'],
      ['post_bounces_contacts', 'post_bounces_default_contacts_params'],
      ['delete_bounces_contacts', 'delete_bounces_default_contacts_params'],
      ['get_unsubscribers_contacts', 'get_unsubscribers_default_contacts'],
      ['post_unsubscribers_contacts', 'post_unsubscribers_default_contacts_params'],
      ['delete_unsubscribers_contacts', 'delete_unsubscribers_default_contacts_params'],
      'post_lists_params',
      ['post_list_contact', 'post_lists-id_params'],
      ['delete_list_contact', 'delete_lists-id_contacts-id_params'],

    ].freeze
  end
end
