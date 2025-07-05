#!/usr/bin/env python

from http.server import BaseHTTPRequestHandler, HTTPServer
import os
from datetime import datetime
import subprocess

SAVE_DIR = "/tmp/ytmpv"

class SimpleHandler(BaseHTTPRequestHandler):
	def do_POST(self):
		content_length = int(self.headers.get('Content-Length', 0))
		post_data = self.rfile.read(content_length).decode('utf-8')

		print("Received from client:", post_data)

		lines = post_data.splitlines()
		if not lines:
			self.send_error(400, "Empty request body")
			return

		if 1 == len (lines) :
			return

		filename = lines[0].strip()
		content = "\n".join(lines[1:])

		# Ensure target directory exists
		os.makedirs(SAVE_DIR, exist_ok=True)

		# Create full path with date prefix
		date_prefix = datetime.now().strftime("%m%d:%H%M%S")
		full_path = os.path.join(SAVE_DIR, f"{date_prefix} - {filename}.m3u")

		# Write content to file
		with open(full_path, "w") as f:
			f.write("#EXTM3U\n#PLAYLIST:" + filename + "\n")
			f.write(content)

		print(f"Saved to {full_path}")

		# List files in the directory
		subprocess.check_output(["plctrl", "optimize", full_path], text=True)
		os.system ("dunstify ytmpv " + "\"" + filename + "\"")

		# Respond
		self.send_response(200)
		self.send_header("Content-type", "text/plain")
		self.end_headers()
		self.wfile.write(b"Saved")

# Start server
if __name__ == "__main__":
	server = HTTPServer(("localhost", 8765), SimpleHandler)
	print("YTMPV Server running at http://localhost:8765/")
	server.serve_forever()
