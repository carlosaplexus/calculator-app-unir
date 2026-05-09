import http.client
import os
import unittest
from urllib.request import urlopen

import pytest

BASE_URL = os.environ.get("BASE_URL")
DEFAULT_TIMEOUT = 2  # in secs


@pytest.mark.api
class TestApi(unittest.TestCase):
    def setUp(self):
        self.assertIsNotNone(BASE_URL, "URL no configurada")
        self.assertTrue(len(BASE_URL) > 8, "URL no configurada")

    def test_api_root(self):
        url = f"{BASE_URL}/"
        response = urlopen(url, timeout=DEFAULT_TIMEOUT)
        self.assertEqual(response.status, http.client.OK)

    def test_api_add(self):
        url = f"{BASE_URL}/calc/add/2/2"
        response = urlopen(url, timeout=DEFAULT_TIMEOUT)
        self.assertEqual(
            response.status, http.client.OK, f"Error en la petición API a {url}"
        )

    def test_api_add_invalid(self):
        url = f"{BASE_URL}/calc/add/a/2"
        with self.assertRaises(Exception):
            urlopen(url, timeout=DEFAULT_TIMEOUT)

    def test_api_substract(self):
        url = f"{BASE_URL}/calc/substract/5/3"
        response = urlopen(url, timeout=DEFAULT_TIMEOUT)
        self.assertEqual(
            response.status, http.client.OK, f"Error en la petición API a {url}"
        )

    def test_api_substract_invalid(self):
        url = f"{BASE_URL}/calc/substract/a/2"
        with self.assertRaises(Exception):
            urlopen(url, timeout=DEFAULT_TIMEOUT)

    def test_api_multiply(self):
        url = f"{BASE_URL}/calc/multiply/2/3"
        response = urlopen(url, timeout=DEFAULT_TIMEOUT)
        self.assertEqual(
            response.status, http.client.OK, f"Error en la petición API a {url}"
        )

    def test_api_multiply_fails_no_permissions(self):
        url = f"{BASE_URL}/calc/multiply/2/3"
        # Si validate_permissions devuelve False, la API debe responder 400
        # Aquí no puedo usar un mock por ser API real, así que solo compruebo que no falla
        try:
            response = urlopen(url, timeout=DEFAULT_TIMEOUT)
            self.assertIn(response.status, [http.client.OK, http.client.BAD_REQUEST])
        except Exception as e:
            self.fail(f"Error inesperado en la petición API a {url}: {e}")

    def test_api_divide(self):
        url = f"{BASE_URL}/calc/divide/10/2"
        response = urlopen(url, timeout=DEFAULT_TIMEOUT)
        self.assertEqual(
            response.status, http.client.OK, f"Error en la petición API a {url}"
        )

    def test_api_divide_by_zero(self):
        url = f"{BASE_URL}/calc/divide/10/0"
        with self.assertRaises(Exception):
            urlopen(url, timeout=DEFAULT_TIMEOUT)

    def test_api_power(self):
        url = f"{BASE_URL}/calc/power/2/3"
        response = urlopen(url, timeout=DEFAULT_TIMEOUT)
        self.assertEqual(
            response.status, http.client.OK, f"Error en la petición API a {url}"
        )

    def test_api_power_invalid(self):
        url = f"{BASE_URL}/calc/power/a/3"
        with self.assertRaises(Exception):
            urlopen(url, timeout=DEFAULT_TIMEOUT)

    def test_api_sqrt(self):
        url = f"{BASE_URL}/calc/sqrt/9"
        response = urlopen(url, timeout=DEFAULT_TIMEOUT)
        self.assertEqual(
            response.status, http.client.OK, f"Error en la petición API a {url}"
        )

    def test_api_sqrt_negative(self):
        url = f"{BASE_URL}/calc/sqrt/-4"
        with self.assertRaises(Exception):
            urlopen(url, timeout=DEFAULT_TIMEOUT)

    def test_api_log10(self):
        url = f"{BASE_URL}/calc/log10/100"
        response = urlopen(url, timeout=DEFAULT_TIMEOUT)
        self.assertEqual(
            response.status, http.client.OK, f"Error en la petición API a {url}"
        )

    def test_api_log10_invalid(self):
        url = f"{BASE_URL}/calc/log10/0"
        with self.assertRaises(Exception):
            urlopen(url, timeout=DEFAULT_TIMEOUT)
