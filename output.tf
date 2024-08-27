output "app_server_ip" {
  description = "The public IP address of the webapp server"
  value       = google_compute_instance.app_server.network_interface[0].access_config[0].nat_ip
}

output "db_connection_name" {
  description = "The connection name of the Cloud SQL instance"
  value       = google_sql_database_instance.webapp_db.connection_name
}
