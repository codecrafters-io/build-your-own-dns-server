<?php
error_reporting(E_ALL);

$udp_socket = socket_create(AF_INET, SOCK_DGRAM, SOL_UDP);

// Since the tester restarts your program quite often, setting SO_REUSEADDR
// ensures that we don't run into 'Address already in use' errors
socket_set_option($udp_socket, SOL_SOCKET, SO_REUSEADDR, 1);

socket_bind($udp_socket, '127.0.0.1', 2053);

while (true) {
    $buf = $from = '';
    $port = 0;
    if (@socket_recvfrom($udp_socket, $buf, 512, 0, $from, $port) === false) {
        fwrite(STDERR, 'Error receiving data: ' . socket_strerror(socket_last_error($udp_socket)) . "\n");
        break;
    }
    socket_sendto($udp_socket, '', 0, 0, $from, $port);
}
